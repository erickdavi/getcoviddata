#!/bin/bash
function get_request(){
    echo ${REQUESTDATA[@]} | jq '.[]|.request|.[]|"--request \(.method) \(.url)"'  | sed 's/"//g' | awk '{printf("%s %s '\''%s'\''",$1,$2,$3) }'

}

function get_header(){
    
    echo ${REQUESTDATA[@]} | jq '.[]|.headers|.[]|"--header \(.key): \(.value)"' | sed 's/"//g' | awk '{printf("%s '\''%s %s'\'' ",$1,$2,$3)}'
}

function connect(){
    BASECOMM="curl -s --location"
    REQUESTDATA=($(cat ./http_header.json))
    CACHEFILE="cache.json"
    REQUEST=$(get_request)
    HEADER=$(get_header)
    DATA=$(eval $BASECOMM $REQUEST $HEADER )
    echo $DATA > ${CACHEFILE}
}

function clear(){
    unset DATA
    rm ${CACHEFILE}
}

function show(){ 
    INDEX="$2"
    SEARCH=$(echo $1 | awk '{printf("%s'\''",$0)}') 
    BASECOMM="jq '.[${INDEX}]${SEARCH}"
    #echo $BASECOMM
    cat ${CACHEFILE} | eval ${BASECOMM}
}

function showFirst(){ 
    SEARCH=$(echo $* | awk '{printf("%s'\''",$0)}')
    BASECOMM="jq '.[2]'"
    #echo $BASECOMM
    cat ${CACHEFILE} | eval $BASECOMM

}

function showLast(){ 
    SEARCH=$(echo $* | awk '{printf("%s'\''",$0)}')
    BASECOMM="jq '.[-1]'"
    #echo $BASECOMM
    cat ${CACHEFILE} | eval $BASECOMM

}