## CHSC project shortcuts


# wesper
alias wesper-cd="cd /Users/conorhayes/project/CHSC_clients/wesper"
export AWS_DEFAULT_PROFILE="wesper"
alias wesper-pip="aws codeartifact login --tool pip --domain wesper --domain-owner 834169864158 --repository wesper-internal"
alias wesper-twine="aws codeartifact login --tool twine --domain wesper --domain-owner 834169864158 --repository wesper-internal"
alias wesper-nopip="python -m pip config unset global.index-url"

alias wesper-ecr="aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 834169864158.dkr.ecr.us-east-1.amazonaws.com"

DEVTOOLS_PATH="/Users/conorhayes/project/CHSC_clients/wesper/DevTools/"
alias tatch="${DEVTOOLS_PATH}/venv/bin/python ${DEVTOOLS_PATH}/cli/tatch.py"

# soe
alias soe-cd="cd /Users/conorhayes/project/CHSC_clients/SOE_EFCTV"

# yutao
alias raas-cd="cd /Users/conorhayes/project/CHSC_clients/yutao_projects/hybrid_lab"
