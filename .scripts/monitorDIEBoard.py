import requests
import time
import sendSMS

def check_site():
    # Get site
    r1 = requests.get('http://www.su.ualberta.ca/governance/committees/die/')
    page = {r1.text}
    while True: 
        r2 = requests.get('http://www.su.ualberta.ca/governance/committees/die/')
        page.add(r2.text)
        if len(page) > 1:
            sendSMS.send_text('DIE Board page has changed')
        else:
            print "No change so far."
        time.sleep(30)


check_site()
