require 'xcodeproj'

project_path = 'ios/Runner.xcodeproj'
project = Xcodeproj::Project.open(project_path)
target = project.targets.find { |t| t.name == 'Runner' }

project.root_object.known_regions << 'tr' unless project.root_object.known_regions.include?('tr')
project.root_object.known_regions << 'en' unless project.root_object.known_regions.include?('en')

runner_group = project.main_group.find_subpath('Runner', false)

strings_group = runner_group.children.find { |c| c.name == 'InfoPlist.strings' }
unless strings_group
  strings_group = project.new(Xcodeproj::Project::Object::PBXVariantGroup)
  strings_group.name = 'InfoPlist.strings'
  runner_group << strings_group
end

en_ref = strings_group.children.find { |c| c.name == 'en' }
unless en_ref
  en_ref = project.new(Xcodeproj::Project::Object::PBXFileReference)
  en_ref.name = 'en'
  en_ref.path = 'en.lproj/InfoPlist.strings'
  en_ref.source_tree = '<group>'
  strings_group << en_ref
end

tr_ref = strings_group.children.find { |c| c.name == 'tr' }
unless tr_ref
  tr_ref = project.new(Xcodeproj::Project::Object::PBXFileReference)
  tr_ref.name = 'tr'
  tr_ref.path = 'tr.lproj/InfoPlist.strings'
  tr_ref.source_tree = '<group>'
  strings_group << tr_ref
end

resources_build_phase = target.resources_build_phase
unless resources_build_phase.files_references.include?(strings_group)
  build_file = project.new(Xcodeproj::Project::Object::PBXBuildFile)
  build_file.file_ref = strings_group
  resources_build_phase.files << build_file
end

project.save
puts "Successfully added localization to Xcode project"
