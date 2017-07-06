# Copyright 2017, Google, Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "rails_helper"

RSpec.feature "Cat Friends" do
  before :all do
    skip "End-to-end test skipped" unless E2E.run?

    File.open File.expand_path("../../app.yaml", __FILE__) do |file|
      configuration = file.read
      configuration.sub! "[SECRET_KEY]",                    ENV["RAILS_SECRET_KEY_BASE"]
      configuration.sub! "[YOUR_INSTANCE_CONNECTION_NAME]", ENV["CLOUD_SQL_MYSQL_CONNECTION_NAME"]

      file.write configuration
    end

    @url = E2E.url
  end

  scenario "should display a list of cats" do
    visit "/"

    expect(page).to have_content "A list of my Cats Ms. Paws is 2 years old! Mr. Whiskers is 4 years old!"
  end
end