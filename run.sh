#!/bin/sh

erl \
 -pa deps/*/ebin \
 -pa apps/*/ebin \
 -boot start_sasl

