{-# LANGUAGE OverloadedStrings #-}
module Main where
import Control.Lens hiding ((.=))
import Control.Monad (void,forever)
import Network.Wreq
import Network.Wreq.Types
import Network.Wreq.Lens
import Data.Aeson
import Data.Text (pack)
import System.Environment as IO

api sid token = "https://" ++ sid ++ ":"++ token ++"@api.twilio.com/2010-04-01/Accounts/" ++ sid ++ "/Messages.json"
envSid   = IO.getEnv "TWC_SID"
envToken = IO.getEnv "TWC_TOKEN"
envSMSID = IO.getEnv "TWC_SMSID" -- your account From # in IE.64 format
envSMSTG = IO.getEnv "TWC_SMSTG" -- To # in IE.64 format

data Twilio = SMS { sendSMS :: IO () }

sms :: String ->Twilio
sms msg = SMS $ do
  sid   <- envSid
  token <- envToken
  smsID <- envSMSID
  smsTarget <- envSMSTG
  let params = [
        partText "To" (pack smsTarget),
        partText "From" (pack smsID),
        partText "Body" (pack msg)
        ]
  void (post (api sid token) params)

main :: IO ()
main = sendSMS . sms =<< getLine
