#!/usr/bin/env bash

echo "Compiling the Tester..."
${LDPLBIN:-ldpl} tester.ldpl -o=tester
./tester
rm tester
