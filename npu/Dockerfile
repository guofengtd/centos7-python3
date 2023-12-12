FROM centos7-python3.9.6:latest

WORKDIR /app

ADD main.py /app
ADD requirements.txt /app

RUN echo "source /usr/local/Ascend/ascend-toolkit/set_env.sh" >> ~/.bashrc

RUN pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
RUN python3 -m pip install --upgrade pip

RUN pip3 install -r requirements.txt

CMD [ "python3", "main.py" ]
