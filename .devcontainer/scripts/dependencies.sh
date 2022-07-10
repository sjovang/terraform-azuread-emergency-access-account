#!/usr/bin/env bash

set -e

/home/linuxbrew/.linuxbrew/bin/brew install terraform-docs
/home/linuxbrew/.linuxbrew/bin/brew install pre-commit

/usr/local/bin/tflint --init -c ./.tflint.d/.tflint.hcl
/home/linuxbrew/.linuxbrew/bin/pre-commit install