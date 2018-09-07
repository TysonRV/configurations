
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

# MacPorts Installer addition on 2017-01-26_at_10:18:14: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

configure_gcloud () {
   export CLOUD_SDK_ROOT="/opt/google-cloud-sdk"
   export GAE_SDK_ROOT="${CLOUD_SDK_ROOT}/platform/google_appengine"
   export PYTHONPATH="${PYTHONPATH}:${GAE_SDK_ROOT}"

   # The next line updates PATH for the Google Cloud SDK. (dev_appserver, gcloud etc.)
   if [ -f "${CLOUD_SDK_ROOT}/path.bash.inc" ]; then
       source "${CLOUD_SDK_ROOT}/path.bash.inc"
   fi

   # The next line enables shell command completion for gcloud.
   if [ -f "${CLOUD_SDK_ROOT}/completion.bash.inc" ]; then
       source "${CLOUD_SDK_ROOT}/completion.bash.inc"
   fi
}

configure_gcloud
