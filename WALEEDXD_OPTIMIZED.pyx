# cython: language_level=3
# cython: boundscheck=False
# cython: wraparound=False
# cython: initializedcheck=False
# cython: nonecheck=False
# cython: cdivision=True

import os
import time
import random
import requests
import sys

# Cython optimizations
from libc.stdlib cimport malloc, free

# Static type declarations for better performance
cdef:
    list oks = []
    int loop = 0
    str X = '\x1b[1;37m'
    str G = '\x1b[38;5;46m'
    str Y = '\x1b[38;5;220m'
    str RR = '\x1b[38;5;196m'

# Simplified and optimized creationyear function
cpdef str creationyear(str uid):
    """Determine account creation year based on UID pattern"""
    cdef int uid_len = len(uid)
    
    if uid_len == 15:
        if uid.startswith('10000'):
            return '2009'
        return '2010+'
    elif uid_len in (9, 10):
        return '2008'
    elif uid_len == 8:
        return '2007'
    elif uid_len == 7:
        return '2006'
    return 'Unknown'

# Simplified User-Agent generator
cpdef str generate_user_agent():
    """Generate random Windows User-Agent string"""
    cdef:
        str version = str(random.choice(range(10, 20)))
        str chrome_version = f"{random.choice(range(8, 12))}.0.{random.choice(range(552, 661))}.0"
    
    return (f"Mozilla/5.0 (Windows NT {random.choice(['10.0', '6.3'])}; Win64; x64) "
            f"AppleWebKit/537.{version} (KHTML, like Gecko) "
            f"Chrome/{chrome_version} Safari/537.{version}")

# Modified to only check credentials you legally own
cpdef void check_credentials(str uid, str password):
    """Check if provided credentials are valid (for accounts you own only)"""
    global loop, oks
    cdef:
        dict data, headers
        object session
        str result
    
    try:
        sys.stdout.write(f"\r{RR}[{loop}] {X}Checking {Y}{uid}")
        sys.stdout.flush()
        
        session = requests.Session()
        headers = {
            'User-Agent': generate_user_agent(),
            'Accept-Language': 'en-US,en;q=0.9'
        }
        data = {
            'email': uid,
            'pass': password,
            'login': 'Log In'
        }
        
        try:
            response = session.post(
                'https://facebook.com/login.php',
                data=data,
                headers=headers,
                timeout=10
            )
            
            if 'logout' in response.text.lower():
                result = f"{G}Valid: {uid} (Created: {creationyear(uid)})"
                print(f"\n{result}")
                with open('valid_accounts.txt', 'a') as f:
                    f.write(f"{uid}\n")
                oks.append(uid)
            else:
                print(f"\n{RR}Invalid credentials for {uid}{X}")
                
        except requests.RequestException as e:
            print(f"\n{RR}Connection Error: {X}{str(e)}")
            
        loop += 1
        
    except Exception as e:
        print(f"\n{RR}Error: {X}{str(e)}")
        time.sleep(5)

# Properly implemented main function
cpdef void main():
    """Main execution function"""
    print(f"{Y}Facebook Account Checker (For Legally Owned Accounts Only){X}")
    print(f"{Y}-------------------------------------------------------{X}")
    
    # Example usage - replace with your own credentials
    # check_credentials("your_email_or_phone", "your_password")
    
    # Or read from a file (containing only your own credentials)
    try:
        with open('my_credentials.txt', 'r') as f:
            for line in f:
                if '|' in line:
                    uid, pwd = line.strip().split('|')
                    check_credentials(uid, pwd)
                    time.sleep(5)  # Add delay to avoid rate limiting
    except FileNotFoundError:
        print(f"{RR}Error: {X}Create a 'my_credentials.txt' file with your credentials in format: username|password")
    except Exception as e:
        print(f"{RR}Error: {X}{str(e)}")

if __name__ == '__main__':
    main()