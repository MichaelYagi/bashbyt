Major work in progress. 

Bash scripts to render and push Tidbyt apps on a schedule. You must install [pixlet](https://tidbyt.dev/docs/build/installing-pixlet).

Quickstart by following step 1, 2, then step 8 below. You may have to login via `pixlet login` first.

1. Login to Pixlet to get Device ID by running `pixlet login`, ensure you can see a list of devices by running `pixlet devices`
2. Create file in root directory `tidbyt.config` and update with your [api key](https://tidbyt.dev/docs/integrate/pushing-apps) `api_key=<api_key>`
3. Create folder with .star Tidbyt script
4. Create `run_script.sh` to render a .webp file and push it to Tidbyt device. See [this script](https://github.com/MichaelYagi/bashbyt/blob/main/db_characters/run_script.sh) as an example
5. Update `run_scripts.sh` with created scripts, passing as input the ttl
6. Execute using keyword `source`
7. Execute in a loop using approriate ttl bucket
8. Run `bash run_scripts.sh`

To delete an installation, run script `bash delete_install.sh <installation_id>`. Find installationID's in `run_script.sh`.
