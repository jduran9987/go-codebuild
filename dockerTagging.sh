#!/bin/bash

export IMAGE_TAG=latest

if [ "$CODEBUILD_SOURCE_VERSION" != "main" ] && ([ "$CODEBUILD_WEBHOOK_BASE_REF" != "refs/heads/main" ] || [ "$CODEBUILD_WEBHOOK_BASE_REF" == "" ])
then
    export DATE_SUFFIX=$(date +%s)
    export IMAGE_TAG=$CODEBUILD_RESOLVED_SOURCE_VERSION-$DATE_SUFFIX
fi

echo $IMAGE_TAG