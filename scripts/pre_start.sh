echo "**** syncing venv to workspace, please wait. This could take a while on first startup! ****"
rsync --remove-source-files -rlptDu --ignore-existing /venv/ /workspace/venv/

echo "**** syncing stable diffusion to workspace, please wait ****"
rsync --remove-source-files -rlptDu --ignore-existing /stable-diffusion-webui/ /workspace/stable-diffusion-webui/
rsync --remove-source-files -rlptDu --ignore-existing /StableStudio/ /workspace/StableStudio/
rsync --remove-source-files -rlptDu --ignore-existing /dreambooth/ /workspace/dreambooth/
rsync --remove-source-files -rlptDu --ignore-existing /DreamBooth_Stable_Diffusion.ipynb /workspace/

if [[ -n $STORJ_ACCESS && -n $STORJ_BUCKET && -n $STORJ_MODEL_PATH && ! -f /workspace/stable-diffusion-webui/models/Stable-diffusion/$(basename "$STORJ_MODEL_PATH") ]]
then
    echo "Downloading model from the Storj network"
    uplink cp --access $STORJ_ACCESS --interactive=false --parallelism 16 --recursive sj://$STORJ_BUCKET/$STORJ_MODEL_PATH /workspace/stable-diffusion-webui/models/Stable-diffusion/
fi

if [[ $RUNPOD_STOP_AUTO ]]
then
    echo "Skipping auto-start of webui"
else
    echo "Started webui through relauncher script"
    cd /workspace/stable-diffusion-webui
    python relauncher.py &
    echo "Started Stable Studio with the webui plugin"
    cd /workspace/StableStudio
    yarn dev:use-webui-plugin --host 0.0.0.0 &
fi
