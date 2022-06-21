#!/bin/bash

set -eux

if [ "$CODEBUILD_WEBHOOK_TRIGGER" = "PULL_REQUEST_MERGED" ] || [ "$CODEBUILD_SOURCE_VERSION" = "" ] || [ "$CODEBUILD_SOURCE_VERSION" = "main"]
then
    export IMAGE_TAG=latest
else
    export DATE_SUFFIX=$(date +%s)
    export IMAGE_TAG=$CODEBUILD_RESOLVED_SOURCE_VERSION-$DATE_SUFFIX
fi