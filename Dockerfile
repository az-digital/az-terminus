FROM uadrupal/base_drush_composer:1.0.1

# Install CGR
RUN composer global require consolidation/cgr:2.0.4

# Install terminus.
RUN cgr pantheon-systems/terminus:1.8.0

# Set up ~/.ssh
RUN mkdir $HOME/.ssh \
  && echo "Host *.drush.in\n    StrictHostKeyChecking no" >> $HOME/.ssh/config \
  && chmod 700 $HOME/.ssh \
  && chmod 600 $HOME/.ssh/*
