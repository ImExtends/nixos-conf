import XMonad
{- import qualified Rofi as Rofi-}

import XMonad.Layout.IndependentScreens

import XMonad.Config.Azerty

import XMonad.Actions.CopyWindow
import XMonad.Actions.SpawnOn
import qualified XMonad.Actions.Commands as XCommands

import XMonad.Hooks.SetWMName (setWMName)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.FadeInactive  ( fadeInactiveLogHook )

import XMonad.Util.SpawnOnce
import XMonad.Util.NamedScratchpad
import XMonad.Util.EZConfig (additionalKeysP, removeKeysP, additionalMouseBindings, checkKeymap)
import XMonad.Util.Run (safeSpawn)
import XMonad.Util.Dmenu         as Dmenu
import XMonad.Util.NamedWindows

import Data.Monoid
import qualified Data.Map        as M
import Data.List (intercalate)

import System.Exit (exitSuccess)
import System.IO

import qualified XMonad.StackSet as W

--Polybar imports
import qualified Codec.Binary.UTF8.String              as UTF8
import qualified DBus                                  as D
import qualified DBus.Client                           as D
import           XMonad.Hooks.DynamicLog

myTerminal      = "kitty"

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

scriptFile :: String -> String
scriptFile script = "/home/extends/Images/scripts/" ++ script

myClickJustFocuses :: Bool
myClickJustFocuses = False

notify :: MonadIO m => String -> String -> m()
notify notificationTitle notificationMessage = safeSpawn "notify-send" [notificationTitle, notificationMessage]

myBorderWidth   = 0
myModMask       = mod1Mask

{-myScreenTools :: [(String, X())]
myScreenTools = [
                  ("Gif recorder", spawn (scriptFile "screengif.sh") >> notify "gif" "Use M-S-g to stop gif-recording")
                , ("Screenshot-copy", spawn (scriptFile "screenshot.sh") >> notify "Screenshot" "Screenshot taken, pasted to clipboard")
                ]-}

myKeys = concat [ myMediaKeys, myOtherKeys, myWSKeys, myScreenKeys ] 
    where
    myMediaKeys :: [(String, X())]
    myMediaKeys = [
                    ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume 0 -5%")
                  , ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume 0 +5%")
                  , ("<XF86AudioMute>", spawn "pactl set-sink-mute 0 toggle")
                  , ("<XF86AudioMicMute>", spawn "pactl set-source-mute 0 toggle")
                  , ("<XF86MonBrightnessDown>", spawn "brightnessctl set 4%-")
		  , ("<XF86MonBrightnessUp>", spawn "brightnessctl set 4%+")
		  ]
  
    myScreenKeys :: [(String, X())]
    myScreenKeys = [
                    --("M-e", Rofi.promptRunCommand def myScreenTools)
		   ]


    myOtherKeys :: [(String, X())]
    myOtherKeys = [ 
                  ("M-<Return>", spawn $ "kitty")
                , ("M-d", spawn "rofi -show drun")
                , ("M-n", refresh)

                , ("M-S-g", spawn "killall -INT -g giph")

                , ("M-S-e", io exitSuccess)

                , ("M-S-q", kill)
                , ("M-S-r", spawn "xmonad --recompile; xmonad --restart")
                ]

    myLayoutKeys :: [(String, X())]
    myLayoutKeys = [
                     ("M-<Space>", sendMessage NextLayout)
		   , ("M-m", windows W.focusMaster)
		   , ("M-j", windows W.focusDown)
                   , ("M-k", windows W.focusUp)
                   
		   , ("M-S-<Return>", windows W.swapMaster)
		   , ("M-S-j", windows W.swapDown)
                   , ("M-S-k", windows W.swapUp)
                            
                   , ("M-h", sendMessage Shrink)
                                     
                   , ("M-l", sendMessage Expand)
                                                        
                   , ("M-t", withFocused $ windows . W.sink)
		   ]

    myWSKeys :: [(String, X())]
    myWSKeys =  concat $ [ [ ("M-" ++ key, runActionOnWorkspace W.view wspN)
                      , ("M-" ++ key, runActionOnWorkspace W.shift wspN)
                      , ("M-S-" ++ key, runActionOnWorkspace copy wspN)
                  ] 
                | (key, wspN) <- zip ["<Ampersand>", "<Eacute>", "<Quotedbl>", "<Apostrophe>", "<Prenleft>", "<Minus>", "<Egrave>", "<Underscore>", "<Ccedilla>", "<Agrave>"] [1..10 :: Int]
                ]
                    where
                    runActionOnWorkspace action wspNum = do
                      wsps <- workspaces' <$> asks config
                      windows $ onCurrentScreen action (wsps !! (wspNum - 1)) 

myMouseBindings :: [((KeyMask, Button), Window -> X ())]
myMouseBindings =
    [ ((mod1Mask, button1), \w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster)
    , ((mod1Mask, button3), \w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster)
    ]

myLayout = tiled ||| Mirror tiled ||| Full
  where
     tiled   = Tall nmaster delta ratio
     nmaster = 1
     ratio   = 1/2
     delta   = 3/100

myManageHook = composeAll . concat $
    [ [ className =? "discord"        --> doShift "3" ]
    , [ className =? "electronplayer" --> doShift "4" ]
    , [ className =? "Spotify"        --> doShift "4" ]
    , [ className =? "qutebrowser"    --> doShift "2" ]
    , [ className =? "Chromium-browser"        --> doShift "2" ]
    , [ className =? "Gimp"           --> doShift "5" ]
    , [ className =? "kitty"          --> doFloat ]
    ]

myEventHook = mempty

data LibNotifyUrgencyHook = LibNotifyUrgencyHook deriving (Read, Show)

instance UrgencyHook LibNotifyUrgencyHook where
    urgencyHook LibNotifyUrgencyHook w = do
        name     <- getName w
        Just idx <- fmap (W.findTag w) $ gets windowset

        safeSpawn "notify-send" [show name, "workspace " ++ idx]

myStartupHook :: X ()
myStartupHook = do
        setWMName "LG3D"
        spawnOnce "electronplayer"
        spawnOnce "feh --bg-scale /home/extends/Images/Wallpapers/background.png"
        spawnOnce "xautolock -time 35 -locker 'betterlockscreen --lock blur -u /home/extends/Images/Wallpapers/background.png' &"
	spawnOnce "chromium"
	spawnOnce "Discord"
	spawn "numlockx"

myWorkspaces = map show [1..10]

main :: IO()
main = mkDbusClient >>= main'

main' :: D.Client -> IO()
main' dbus = xmonad $ azertyConfig
         {
            terminal           = myTerminal,
            focusFollowsMouse  = myFocusFollowsMouse,
            clickJustFocuses   = myClickJustFocuses,
            borderWidth        = myBorderWidth,
            modMask            = myModMask,
            workspaces         = myWorkspaces,

            layoutHook         = myLayout,
            manageHook         = myManageHook,
            handleEventHook    = myEventHook,
            logHook            = myPolybarLogHook dbus,
            startupHook        = myStartupHook
          } `additionalKeysP` myKeys
	    `additionalMouseBindings` myMouseBindings

mkDbusClient :: IO D.Client
mkDbusClient = do
  dbus <- D.connectSession
  D.requestName dbus (D.busName_ "org.xmonad.log") opts
  return dbus
 where
  opts = [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]

-- Emit a DBus signal on log updates
dbusOutput :: D.Client -> String -> IO ()
dbusOutput dbus str =
  let opath  = D.objectPath_ "/org/xmonad/Log"
      iname  = D.interfaceName_ "org.xmonad.Log"
      mname  = D.memberName_ "Update"
      signal = (D.signal opath iname mname)
      body   = [D.toVariant $ UTF8.decodeString str]
  in  D.emit dbus $ signal { D.signalBody = body }

polybarHook :: D.Client -> PP
polybarHook dbus =
  let wrapper c s | s /= "NSP" = wrap ("%{F" <> c <> "} ") " %{F-}" s
                  | otherwise  = mempty
      blue   = "#2E9AFE"
      gray   = "#7F7F7F"
      orange = "#ea4300"
      purple = "#9058c7"
      red    = "#722222"
  in  def { ppOutput          = dbusOutput dbus
          , ppCurrent         = wrapper blue
          , ppVisible         = wrapper gray
          , ppUrgent          = wrapper orange
          , ppHidden          = wrapper gray
          , ppHiddenNoWindows = wrapper red
          , ppTitle           = shorten 100 . wrapper purple
          }

myPolybarLogHook dbus = myLogHook <+> dynamicLogWithPP (polybarHook dbus)
myLogHook = fadeInactiveLogHook 0.9
