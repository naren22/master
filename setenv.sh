#!/bin/sh

# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# -----------------------------------------------------------------------------
# Set environment configuration 
# -----------------------------------------------------------------------------

#export JAVA_OPTS="-server"
#export JAVA_OPTS="$JAVA_OPTS -Xms512M -Xmx1024M"
#export JAVA_OPTS="$JAVA_OPTS -XX:NewSize=512m -XX:MaxNewSize=512m"
#export JAVA_OPTS="$JAVA_OPTS -XX:PermSize=256m -XX:MaxPermSize=256m"
#export JAVA_OPTS="$JAVA_OPTS -XX:+UseConcMarkSweepGC"

export CATALINA_OPTS="$CATALINA_OPTS -Xms512M -Xmx1024M -server -XX:+UseParallelGC"
export JAVA_OPTS="$JAVA_OPTS -Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom"

export JAVA_OPTS="$JAVA_OPTS -Duser.timezone=UTC-05:00"

#export CATALINA_OPTS="$CATALINA_OPTS -Dcom.sun.management.jmxremote"
#export CATALINA_OPTS="$CATALINA_OPTS -Dcom.sun.management.jmxremote.port=9090"
#export CATALINA_OPTS="$CATALINA_OPTS -Dcom.sun.management.jmxremote.rmi.port=9090"
#export CATALINA_OPTS="$CATALINA_OPTS -Djava.rmi.server.hostname=192.168.99.100"
## FIXME: host name/IP should be resolved by the docker env
##export CATALINA_OPTS="$CATALINA_OPTS -Djava.rmi.server.hostname=nckmvdsla11363"
#export CATALINA_OPTS="$CATALINA_OPTS -Dcom.sun.management.jmxremote.local.only=false"
#export CATALINA_OPTS="$CATALINA_OPTS -Dcom.sun.management.jmxremote.authenticate=false"
#export CATALINA_OPTS="$CATALINA_OPTS -Dcom.sun.management.jmxremote.ssl=false"