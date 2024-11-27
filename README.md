Major work in progress. 

Bash scripts to render and push Tidbyt apps on a schedule. You must install [pixlet](https://tidbyt.dev/docs/build/installing-pixlet).

Quickstart by following step 1, then step 7 below. You may have to login via `pixlet login` first.

1. Create file in root directory `tidbyt.config` and update with your [api key](https://tidbyt.dev/docs/integrate/pushing-apps) `api_key=<api_key>`
2. Create folder with .star Tidbyt script
3. Create `run_script.sh` to render a .webp file and push it to Tidbyt device. See [this script](https://github.com/MichaelYagi/bashbyt/blob/main/db_characters/run_script.sh) as an example
4. Update `run_scripts.sh` with created scripts, passing as input the ttl
5. Execute using keyword `source`
6. Execute in a loop using approriate ttl bucket
7. Run `bash run_scripts.sh`

To delete an installation, run script `bash delete_install.sh <installation_id>`. Find installationID's in `run_script.sh`.
