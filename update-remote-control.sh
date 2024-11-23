#!/bin/bash

# 로그 파일 설정
LOG_FILE="/home/nhadmin/deploy-control.log"

# 날짜 형식 설정
DATE=$(date '+%Y-%m-%d %H:%M:%S')

# 로그 함수
log() {
    echo "[$DATE] $1" | tee -a "$LOG_FILE"
}

# 프로젝트 디렉토리로 이동
cd /home/nhadmin/remote-control-server || {
    log "프로젝트 디렉토리로 이동 실패"
    exit 1
}

# git pull 실행
log "git pull 시작..."
git pull origin main || {
    log "git pull 실패"
    exit 1
}

# 서비스 재시작
log "서비스 재시작 중..."
sudo systemctl restart remote-control-server || {
    log "서비스 재시작 실패"
    exit 1
}

log "업데이트 및 서비스 시작 완료"
