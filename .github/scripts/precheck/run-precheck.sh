#!/bin/bash
# SPDX-FileCopyrightText: 2020 Efabless Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# SPDX-License-Identifier: Apache-2.0
export TARGET_PATH=$(pwd)
export CARAVEL_ROOT=$(pwd)/caravel
cd ..
export PDK_ROOT=$(pwd)/precheck_pdks
export PRECHECK_ROOT=$TARGET_PATH/mpw_precheck/
export OUTPUT_DIRECTORY=$TARGET_PATH/checks
cd $TARGET_PATH/mpw_precheck/

docker run -v $PRECHECK_ROOT:$PRECHECK_ROOT -v $TARGET_PATH:$TARGET_PATH -v $PDK_ROOT:$PDK_ROOT -v $CARAVEL_ROOT:$CARAVEL_ROOT -e GOLDEN_CARAVEL=$CARAVEL_ROOT -u $(id -u $USER):$(id -g $USER) efabless/mpw_precheck:latest bash -c " cd $PRECHECK_ROOT ; python3 mpw_precheck.py license yaml manifest makefile consistency xor --pdk_root $PDK_ROOT --input_directory $TARGET_PATH --output_directory $OUTPUT_DIRECTORY"
output=$OUTPUT_DIRECTORY/logs/precheck.log

gzipped_file=$OUTPUT_DIRECTORY/logs/precheck.log.gz

if [[ -f $gzipped_file ]]; then
    gzip -d $gzipped_file
fi

grep "Violation Message" $output

cnt=$(grep -c "All Checks Passed" $output)
if ! [[ $cnt ]]; then cnt=0; fi
if [[ $cnt -eq 1 ]]; then exit 0; fi
exit 2
