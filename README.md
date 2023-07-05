# Secure Stable Diffusion Template for RunPod

This [RunPod](https://runpod.io/) template focuses on secure training and inference with Stable Diffusion by securely storing and fetching datasets and checkpoints from the Storj Decentralized Cloud Storage.

## Quickstart

Use this link to run the template in your RunPod account:
https://runpod.io/gsc?template=3jgnr4mriw&ref=se98m3j8

## Included in this Docker image

* [Stable Diffusion Web UI](https://github.com/AUTOMATIC1111/stable-diffusion-webui)
* [Stable Studio](https://github.com/Stability-AI/StableStudio)
* Automated fetching of AI models from your Storj account on startup
* Jupyter Notebook for DreamBooth training and storing the trained checkpoints to your Storj account.

## Environment variables

| Var name | Description |
| -------- | ----------- |
| STORJ_ACCESS | The [access grant](https://docs.storj.io/dcs/concepts/access/access-grants) to use for transferring files from and to your Storj DCS account |
| STORJ_BUCKET | The bucket to use for transferring files from and to your Storj DCS account |
| STORJ_MODEL_PATH | The object key to a specific AI model or a prefix/folder with multiple AI models to automatically download at startup |

If the Docker container is configured with all three environment variables, it will automatically download the AI models at startup.

## How to use

The usage instructions are maintained in the [wiki](https://github.com/storj/secure-stable-diffusion-runpod/wiki).

* [Deploy and launch a pod](https://github.com/storj/secure-stable-diffusion-runpod/wiki/Deploy-and-launch-a-pod)
* [Configure the pod to download your AI models from Storj automatically](https://github.com/storj/secure-stable-diffusion-runpod/wiki/Configure-the-pod-to-download-your-AI-models-from-Storj-automatically)
* [Launch the Stable Diffusion Web UI](https://github.com/storj/secure-stable-diffusion-runpod/wiki/Launch-the-Stable-Diffusion-Web-UI)
* [Launch the Stable Studio](https://github.com/storj/secure-stable-diffusion-runpod/wiki/Launch-the-Stable-Studio)
* [Train your model and upload it to Storj](https://github.com/storj/secure-stable-diffusion-runpod/wiki/Train-your-model-and-upload-it-to-Storj)
