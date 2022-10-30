# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    # can :manage, :all
    can :manage, User, id: user.id
    unless user.id.nil?
      can :create, Cv
      can :create, Section
      can :create, Certificate
      can :create, Course
      can :create, Education
      can :create, Employment
      can :create, Language
      can :create, Reference
      user_cv_ids = user.cvs.pluck(:id)
      user_cv_section_ids = Section.all.select { |s| user_cv_ids.include?(s.cv_id) }.pluck(:id)
      user_cv_section_certificate_ids = Certificate.all.select { |c| user_cv_section_ids.include?(c.section_id) }.pluck(:id)
      user_cv_section_course_ids = Course.all.select { |c| user_cv_section_ids.include?(c.section_id) }.pluck(:id)
      user_cv_section_education_ids = Education.all.select { |e| user_cv_section_ids.include?(e.section_id) }.pluck(:id)
      user_cv_section_employment_ids = Employment.all.select { |e| user_cv_section_ids.include?(e.section_id) }.pluck(:id)
      user_cv_section_language_ids = Language.all.select { |l| user_cv_section_ids.include?(l.section_id) }.pluck(:id)
      user_cv_reference_education_ids = Reference.all.select { |r| user_cv_section_ids.include?(r.section_id) }.pluck(:id)
      can :manage, Cv, id: user_cv_ids
      can :manage, Section, id: user_cv_section_ids
      can :manage, Certificate, id: user_cv_section_certificate_ids
      can :manage, Course, id: user_cv_section_course_ids
      can :manage, Education, id: user_cv_section_education_ids
      can :manage, Employment, id: user_cv_section_employment_ids
      can :manage, Language, id: user_cv_section_language_ids
      can :manage, Reference, id: user_cv_reference_education_ids
    end
  end
end
