#!/bin/bash

set -e

if [ "$CODEBUILD_WEBHOOK_EVENT" = "PULL_REQUEST_MERGED" ] || [ "$CODEBUILD_SOURCE_VERSION" = "" ] || [ "$CODEBUILD_SOURCE_VERSION" = "main" ]
then
    export IMAGE_TAG=latest
else
    export DATE_SUFFIX=$(date +%s)
    export IMAGE_TAG=$CODEBUILD_RESOLVED_SOURCE_VERSION-$DATE_SUFFIX
fi