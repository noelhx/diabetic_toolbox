module DiabeticToolbox
  #:enddoc:
  class Report < ActiveRecord::Base
    belongs_to :member, class_name: 'DiabeticToolbox::Member'
  end
end
