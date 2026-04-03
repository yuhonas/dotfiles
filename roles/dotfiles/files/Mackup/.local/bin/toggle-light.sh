#!/usr/bin/env python

import http.client
import json
import os
from dotenv import load_dotenv

load_dotenv()

conn = http.client.HTTPConnection(os.getenv(
    "HOME_ASSISTANT_HOST"), int(os.getenv("HOME_ASSISTANT_PORT")))

payload = json.dumps({
    "entity_id": "light.wiz_rgbww_tunable_710a10"
})
headers = {
    'Content-Type': 'application/json',
    'Authorization': f"Bearer {os.getenv('HOME_ASSISTANT_TOKEN')}"
}
conn.request("POST", "/api/services/light/toggle", payload, headers)
res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
