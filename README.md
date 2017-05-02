# twc
unix | phone -> unix to sms

# Installation
- `stack build`
- `stack install`

# Getting Stack
`curl -sSL https://get.haskellstack.org/ | sh`

## Example
`cat /dev/urandom | base64 -b 20 | head -1 | twc`
