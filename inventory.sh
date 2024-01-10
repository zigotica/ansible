#!/usr/bin/env bash

echo "{\
  \"homelab\": {\
    \"hosts\": [\"$HOMELAB_HOST_MAIN\"]\
  },\
  \"fallback\": {\
    \"hosts\": [\"$HOMELAB_HOST_FALLBACK\"]\
  },\
  \"servers\": {\
    \"hosts\": [\"$HOMELAB_HOST_MAIN\", \"$HOMELAB_HOST_FALLBACK\"]\
  }\
}"
