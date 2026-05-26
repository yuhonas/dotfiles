# Purpose
Summarize everything that's installed via ansible playbooks so it can be easily digested in the README.md

# Instructions

1. Enumerate through all the ansible yaml files under roles/**/*.yml
2. Do not include
  * roles/linux-apps
  * roles/screenshot
3. Curate everything that's being installed with the name of the software and what it does & categorise them
4. Insert this rich text into the README.md in between the BEGIN/END delimeters
5. Do not put this in a table and do not include the platform, alpha sort all items within their respective categories, replace any existing text within the delimeters

# Target File
README.md
