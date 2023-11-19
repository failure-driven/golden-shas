class Root < SitePrism::Page
  set_url "/"

  element :seed_phrase, :qa, "seed-phrase"
  element :loading, '[data-seed-phrase-target="loading"]', visible: false
end
