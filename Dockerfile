FROM uadrupal/base_drush_composer:2.0.0

# Install CGR
RUN composer global require consolidation/cgr:2.0.5

# Install terminus
RUN cgr pantheon-systems/terminus:2.2.0

# Install jq
RUN apt-get update -y && apt-get install -y jq

# Cherry-pick the scripts we actually want from the complete repo.
RUN cd /tmp \
  && git clone -b '1.4.1' https://bitbucket.org/ua_drupal/uaqs_repository_tools.git \
  && cp uaqs_repository_tools/reposync.sh /usr/local/bin/reposync \
  && rm -Rf uaqs_repository_tools

RUN useradd -ms /bin/bash azdigital

USER azdigital
WORKDIR /home/azdigital

# Set up ~/.ssh
RUN mkdir $HOME/.ssh \
  && echo "Host *.drush.in\n    StrictHostKeyChecking no" >> $HOME/.ssh/config \
  && chmod 700 $HOME/.ssh \
  && chmod 600 $HOME/.ssh/*
