# Jupyter + PyTorch Docker 실습 환경

이 프로젝트는 Docker 컨테이너 안에서 Jupyter Notebook과 PyTorch를 실행하기 위한 예제입니다.

## 1) 준비물

- Docker Desktop 설치 (Windows / macOS)

## 2) 실행 방법

먼저(최초 1회) 로컬 Jupyter 설정 폴더를 준비합니다.

```bash
mkdir -p ~/.jupyter
```

프로젝트 폴더에서 아래 명령 실행:

```bash
docker compose up --build --force-recreate
```

- 처음 실행 시 이미지 빌드 때문에 시간이 오래 걸릴 수 있습니다.
- 빌드가 완료되면 터미널에 Jupyter 접속 URL(토큰 포함)이 출력됩니다.
- 이 프로젝트는 `docker-compose.yml`의 `volumes`로 아래를 마운트합니다.
  - `./` -> `/workspace` (로컬 코드 실시간 반영)
  - `~/.jupyter` -> `/root/.jupyter` (로컬 Jupyter 설정 반영)

브라우저 접속:

- `http://localhost:8888`
- 또는 터미널에 출력된 토큰 URL 사용

## 3) 종료 방법

실행 중인 터미널에서:

```bash
Ctrl + C
```

컨테이너 정리까지 하려면:

```bash
docker compose down
```

## 4) 다음 실행(빠르게)

이미 빌드가 끝난 뒤에는:

```bash
docker compose up --force-recreate
```

## 5) 파일 저장 위치

- 현재 폴더(`./`)가 컨테이너 내부 `/workspace`에 연결되어 있습니다.
- 노트북에서 저장한 파일은 내 로컬 프로젝트 폴더에 그대로 저장됩니다.
- 로컬 `~/.jupyter` 폴더는 컨테이너 내부 `/root/.jupyter`로 연결됩니다.

## 6) 다른 사람에게 공유하기

아래 파일들을 함께 전달하면 됩니다.

- `Dockerfile`
- `docker-compose.yml`
- `README.md`
- 노트북 파일(`.ipynb`) 및 코드

상대방은 프로젝트 폴더에서 아래 한 줄만 실행하면 됩니다.

```bash
docker compose up --build --force-recreate
```

## 7) 자주 있는 문제

- `port is already allocated` 에러: 8888 포트를 다른 프로그램이 사용 중입니다.
  - `docker-compose.yml`에서 `"8888:8888"`의 앞 숫자를 예: `"8890:8888"`으로 변경하세요.

- 빌드가 매우 느림: PyTorch 패키지 다운로드 용량이 커서 첫 빌드는 오래 걸릴 수 있습니다.

## 8) 로컬 IDE로 작성하고 컨테이너에서 실행하기 (Jupyter 없이)

아래 방식은 VS Code, PyCharm 같은 로컬 IDE에서 코드를 작성하고, 실행만 컨테이너에서 하는 방법입니다.

### 8-1. 예제 파일 만들기

프로젝트 폴더에 `main.py` 파일 생성:

```python
import torch

print("PyTorch version:", torch.__version__)
print("CUDA available:", torch.cuda.is_available())
print("Hello from container")
```

### 8-2. 컨테이너 실행(백그라운드)

```bash
docker compose up -d
```

### 8-3. 컨테이너 안에서 파이썬 실행

```bash
docker compose exec notebook python main.py
```

- 출력이 보이면 정상입니다.
- 코드 수정 후 같은 명령을 다시 실행하면 변경 내용이 바로 반영됩니다.

### 8-4. 추가 명령 예시

특정 패키지 import 테스트:

```bash
docker compose exec notebook python -c "import torch, pandas, numpy; print('ok')"
```

컨테이너 쉘 접속:

```bash
docker compose exec notebook bash
```

### 8-5. 작업 종료

```bash
docker compose down
```

### 8-6. 자주 쓰는 흐름 요약

1. 로컬 IDE에서 코드 작성/수정
2. `docker compose up -d` (처음 한 번 또는 필요할 때)
3. `docker compose exec notebook python 파일명.py`
4. 완료 후 `docker compose down`
