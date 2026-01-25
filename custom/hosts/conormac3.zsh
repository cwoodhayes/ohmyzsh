# Host-specific configuration for conormac3 (MacBook)

# pyenv initialization
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# GPG needs the current tty for pinentry
export GPG_TTY=$(tty)

alias update-cli="pip install /Users/conorhayes/project/clitools"
alias clis="/Users/conorhayes/project/clitools/venv/bin/python /Users/conorhayes/project/clitools/clitools/main.py"
alias project="pushd /Users/conorhayes/project"

# CHSC project shortcuts
alias wesper-cd="cd /Users/conorhayes/project/CHSC_clients/wesper"
export AWS_DEFAULT_PROFILE="wesper"
alias wesper-pip="aws codeartifact login --tool pip --domain wesper --domain-owner 834169864158 --repository wesper-internal"
alias wesper-twine="aws codeartifact login --tool twine --domain wesper --domain-owner 834169864158 --repository wesper-internal"
alias wesper-nopip="python -m pip config unset global.index-url"
alias wesper-ecr="aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 834169864158.dkr.ecr.us-east-1.amazonaws.com"

DEVTOOLS_PATH="/Users/conorhayes/project/CHSC_clients/wesper/DevTools/"
alias tatch="${DEVTOOLS_PATH}/venv/bin/python ${DEVTOOLS_PATH}/cli/tatch.py"

alias soe-cd="cd /Users/conorhayes/project/CHSC_clients/SOE_EFCTV"
alias raas-cd="cd /Users/conorhayes/project/CHSC_clients/yutao_projects/hybrid_lab"

# macOS-specific tools and PATH tweaks
alias vinterp="/Users/conorhayes"
export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin"
export PATH="/Users/conorhayes/Library/Python/2.7/bin:$PATH"

# OLD WESPER STUFF

# alias tatch='/Users/conorhayes/tatch/DevTools/cli/venv/bin/python ~/tatch/DevTools/cli/tatch.py'
#
# def deploy-all-lambdas () {
#     deploy-main-api $@;
#     tatch deploylambdas \
#     -d ~/tatch/Backend/lambdas/triggers/backend2-sandbox-create-report-trigger "" \
#     -d ~/tatch/Backend/lambdas/triggers/backend2-sandbox-rawDataEventHandler "" \
#     -d ~/tatch/Backend/lambdas/triggers/lambda-log-notifier "" \
#     -d ~/tatch/Backend/lambdas/triggers/log-queue-consumer "" \
#     -d ~/tatch/Backend/lambdas/triggers/session-viewer-folder-trigger "" \
#     $@;
# }
#
# def deploy-main-api () {
#     tatch deploylambdas \
#     -d ~/tatch/Backend/lambdas/main-api "" $@ \
#     -x local.py local_api_mock_data.py test_ htmlcov main_api_local.db main_api_test.db .pytest_cache .env .gitignore .coverage .DS_Store local_api_mock_data.py __pycache__ \
# }
#
# def deploylambda () {
#     tatch deploylambdas \
#     -d . "" $@
# }
#
# def awsenv () {
#     if [ $# -eq 0 ]
#     then
#         echo $AWS_PROFILE;
#     elif [ $# -eq 1 ]
#     then
#         export AWS_PROFILE=$1;
#     else
#         echo "too many input arguments.";
#     fi
# }
#
# def uuid () {
#     python3 ~/scripts/uuid-converter.py $@
# }
#
# def uuidc() {
#     echo "$(python3 ~/scripts/uuid-converter.py $@)" | tee /dev/tty | pbcopy
# }
#
# def s3md5() {
#     openssl md5 -binary $1 | base64 | tee /dev/tty | pbcopy
# }
