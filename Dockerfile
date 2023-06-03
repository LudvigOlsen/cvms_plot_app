FROM continuumio/miniconda3

WORKDIR /code

# Create the environment:
COPY ./environment.yml /code/environment.yml
RUN conda env create -f environment.yml

# Make RUN commands use the new environment:
SHELL ["conda", "run", "-n", "plt_env", "/bin/bash", "-c"]

# Demonstrate the environment is activated:
RUN echo "Make sure flask is installed:"
RUN python -c "import flask"

COPY . .

# The code to run when container is started:
# server.address 0.0.0.0 ?

ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "plt_env", "streamlit", "run", "app.py", "--server.port", "7860"] 

