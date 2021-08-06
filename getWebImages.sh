#!/bin/bash

authService=$(curl -sS 'http://cdcs17:8083/service/rest/repository/browse/cdc-docker-repo/v2/webarm/auth-service/tags/' \
| grep -oE '([1]\.[0-9]{1,3}\.[0-9]{1,3})' | sort -ruV | sed -n 1p)
chatService=$(curl -sS 'http://cdcs17:8083/service/rest/repository/browse/cdc-docker-repo/v2/webarm/chat-service/tags/' \
| grep -oE '([1]\.[0-9]{1,3}\.[0-9]{1,3})' | sort -ruV | sed -n 1p)
checkListService=$(curl -sS 'http://cdcs17:8083/service/rest/repository/browse/cdc-docker-repo/v2/webarm/check-list-service/tags/' \
| grep -oE '([1]\.[0-9]{1,3}\.[0-9]{1,3})' | sort -ruV | sed -n 1p)
formService=$(curl -sS 'http://cdcs17:8083/service/rest/repository/browse/cdc-docker-repo/v2/webarm/form-service/tags/' \
| grep -oE '([1]\.[0-9]{1,3}\.[0-9]{1,3})' | sort -ruV | sed -n 1p)
messageService=$(curl -sS 'http://cdcs17:8083/service/rest/repository/browse/cdc-docker-repo/v2/webarm/message-service/tags/' \
| grep -oE '([1]\.[0-9]{1,3}\.[0-9]{1,3})' | sort -ruV | sed -n 1p)
monitoringService=$(curl -sS 'http://cdcs17:8083/service/rest/repository/browse/cdc-docker-repo/v2/webarm/monitoring-service/tags/' \
| grep -oE '([1]\.[0-9]{1,3}\.[0-9]{1,3})' | sort -ruV | sed -n 1p)
postOfficeClient=$(curl -sS 'http://cdcs17:8083/service/rest/repository/browse/cdc-docker-repo/v2/webarm/post-office-service/tags/' \
| grep -oE '([1]\.[0-9]{1,3}\.[0-9]{1,3})' | sort -ruV | sed -n 1p)
scriptService=$(curl -sS 'http://cdcs17:8083/service/rest/repository/browse/cdc-docker-repo/v2/webarm/script-service/tags/' \
| grep -oE '([1]\.[0-9]{1,3}\.[0-9]{1,3})' | sort -ruV | sed -n 1p)
updateService=$(curl -sS 'http://cdcs17:8083/service/rest/repository/browse/cdc-docker-repo/v2/webarm/update-service/tags/' \
| grep -oE '([1]\.[0-9]{1,3}\.[0-9]{1,3})' | sort -ruV | sed -n 1p)
workerService=$(curl -sS 'http://cdcs17:8083/service/rest/repository/browse/cdc-docker-repo/v2/webarm/worker-service/tags/' \
| grep -oE '([1]\.[0-9]{1,3}\.[0-9]{1,3})' | sort -ruV | sed -n 1p)
#SPA BLOCK
spaClient=$(curl -sS 'http://cdcs17:8083/service/rest/repository/browse/cdc-docker-repo/v2/webarm/spa-client/tags/' \
| grep -oE '([1]\.[0-9]{1,3}\.[0-9]{1,3})' | sort -ruV | sed -n 1p)
#spaGatewayService=$(curl -s -S 'http://cdcs17:8083/service/rest/repository/browse/cdc-docker-repo/v2/webarm/spa-gateway-service/tags/' \
# | grep -E '([1]\.[0-9]\.[0-9]+[^-])' | awk -F">" '{print $3}' | tr -cd '[:digit:].\n' | sort -t "." -nk1 -nk2 -nk3 -r | sed -n 1p)
#NOPS BLOCK
nopsServer=$(curl -sS 'http://cdcs17:8083/service/rest/repository/browse/cdc-docker-repo/v2/webarm/post-nops-server/tags/' \
| grep -oE '([1]\.[0-9]{1,3}\.[0-9]{1,3})' | sort -ruV | sed -n 1p)
nopsClient=$(curl -sS 'http://cdcs17:8083/service/rest/repository/browse/cdc-docker-repo/v2/webarm/post-nops-client/tags/' \
| grep -oE '([1]\.[0-9]{1,3}\.[0-9]{1,3})' | sort -ruV | sed -n 1p)
#GENERATE .ENV FILE
#echo -e "NOPS_SERVER_TAG=${nopsService}\nNOPS_CLIENT_TAG=${nopsClient}\nAUTH_TAG=${authService}\nFORM_TAG=${formService}\
# \nMESSAGE_TAG=${messageService}\nMONITORING_TAG=${monitoringService}\nPOST_OFFICE_TAG=${postOfficeClient}\
# \nSPA_GW_TAG=${spaGatewayService}\nSCRIPT_TAG=${scriptService}\nWORKER_TAG=${workerService}\nCHECK_LIST_TAG=${checkListService}\
# \nSPA_TAG=${spaClient}\nDB=Host=?; Port=?; User Id=?; Pooling=False; Password=?; Database=?" \
# | tee /home/cdc/post/deploy/.env
#MAKE COMPOSE
#cd /home/cdc/post/deploy/
#docker-compose --env-file .env -f docker-compose.web.yml -p web up -d
#cd -
cd images-web/
rm -f *.tar
# PULL IMAGES FROM REPO
docker pull cdcs17:8443/webarm/script-service:${scriptService}
docker pull cdcs17:8443/webarm/message-service:${messageService}
docker pull cdcs17:8443/webarm/auth-service:${authService}
docker pull cdcs17:8443/webarm/form-service:${formService}
docker pull cdcs17:8443/webarm/monitoring-service:${monitoringService}
#docker pull cdcs17:8443/webarm/spa-gateway-service:${spaGatewayService}
docker pull cdcs17:8443/webarm/post-office-service:${postOfficeClient}
docker pull cdcs17:8443/webarm/spa-client:${spaClient}
docker pull cdcs17:8443/webarm/worker-service:${workerService}
docker pull cdcs17:8443/webarm/check-list-service:${checkListService}
docker pull cdcs17:8443/webarm/post-nops-server:${nopsServer}
docker pull cdcs17:8443/webarm/post-nops-client:${nopsClient}
# SAVE ACTUAL CONTEINERS
docker save -o script-service${scriptService}.tar cdcs17:8443/webarm/script-service:${scriptService} && chmod 766 script-service${scriptService}.tar
docker save -o message-service${messageService}.tar cdcs17:8443/webarm/message-service:${messageService} && chmod 766 message-service${messageService}.tar
docker save -o auth-service${authService}.tar cdcs17:8443/webarm/auth-service:${authService} && chmod 766 auth-service${authService}.tar
docker save -o form-service${formService}.tar cdcs17:8443/webarm/form-service:${formService} && chmod 766 form-service${formService}.tar
docker save -o monitoring-service${monitoringService}.tar cdcs17:8443/webarm/monitoring-service:${monitoringService} && chmod 766 monitoring-service${monitoringService}.tar
#docker save -o spa-gateway-service${spaGatewayService}.tar cdcs17:8443/webarm/spa-gateway-service:${spaGatewayService} && chmod 766 spa-gateway-service${spaGatewayService}.tar
docker save -o post-office-service${postOfficeClient}.tar cdcs17:8443/webarm/post-office-service:${postOfficeClient} && chmod 766 post-office-service${postOfficeClient}.tar
docker save -o spa-client${spaClient}.tar cdcs17:8443/webarm/spa-client:${spaClient} && chmod 766 spa-client${spaClient}.tar
docker save -o worker-service${workerService}.tar cdcs17:8443/webarm/worker-service:${workerService} && chmod 766 worker-service${workerService}.tar
docker save -o check-list-service${checkListService}.tar cdcs17:8443/webarm/check-list-service:${checkListService} && chmod 766 check-list-service${checkListService}.tar
docker save -o post-nops-server${nopsServer}.tar cdcs17:8443/webarm/post-nops-server:${nopsServer} && chmod 766 post-nops-server${nopsServer}.tar
docker save -o post-nops-service${nopsClient}.tar cdcs17:8443/webarm/post-nops-client:${nopsClient} && chmod 766 post-nops-service${nopsClient}.tar
echo -e '\n\nALL DONE!!\n\n'