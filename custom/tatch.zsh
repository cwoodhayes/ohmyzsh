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
