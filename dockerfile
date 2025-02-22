FROM rocker/rstudio:4.4.1

# Set working directory
WORKDIR /home/rstudio/project

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libssl-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    libgit2-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy project files
COPY . /home/rstudio/project/

# Install R packages
# List your required packages here
RUN R -e "install.packages(c('renv', 'devtools', 'tidyverse', 'knitr', 'rmarkdown', 'lavaan', 'semTools', 'cSEM', 'stringr'), repos='https://cran.rstudio.com/')"

# If you use renv for package management (recommended)
# RUN R -e "renv::restore()"

# Expose port for RStudio
EXPOSE 8787

# Set up environment variables
ENV USER=rstudio
ENV PASSWORD=password

# The rstudio image starts the server automatically