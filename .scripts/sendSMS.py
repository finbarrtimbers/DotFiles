#!/usr/local/bin/python
import sys
from twilio.rest import TwilioRestClient
  
# Your Account Sid and Auth Token from twilio.com/user/account
account_sid = "ACeef6a0ea6dceb539695ad8d28cc841cd"
auth_token  = "801427f0ff095d19a5df13618a246bb7"
client = TwilioRestClient(account_sid, auth_token)

textMessage = "Scott Young is beautiful"
message = client.sms.messages.create(body=textMessage,
                                     to="+17809911532",    # Replace with your phone number
                                     from_="+17806281786") # Replace with your Twilio number
