#!/bin/bash

bundle check || bundle install

bundle exec foreman start -f Procfile.dev

