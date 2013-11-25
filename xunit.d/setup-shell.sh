#
# Copyright (c) 2013, Juan Luis Álvarez Martínez
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice, this
#    list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#
# -------------------------------------------------------------------------------
#
# setup-shell.sh
#
#     This script will configure a shell so it can run the shellUnit scripts.
# In shell not providing the [[ operator this script will create an alias to
# an alternative implementation, for example busybox.
#
# -------------------------------------------------------------------------------
#


setup_alternatives () {
	#Check for busybox
	if busybox >/dev/null 2>/dev/null
	then
		SHU_BUSYBOX='yes'
	else
		SHU_BUSYBOX='no'
		return -1
	fi

	#[[ Alternatives
	if [[ 1 = 1 ]] >/dev/null 2>/dev/null
	then
		SHU_BRACKETS='native'
	else
		alias [[="busybox [["
		SHU_BRACKETS='busybox'
	fi
}
