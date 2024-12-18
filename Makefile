post:
	@bundle exec jekyll post $(filter-out $@,$(MAKECMDGOALS))

%:      # thanks to chakrit
	@:    # thanks to William Pursell