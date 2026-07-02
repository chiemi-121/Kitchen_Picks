class HomesController < ApplicationController
  layout "top", only: [:top]

  def top
    # トップページは案内ページなのでデータは不要
  end

  def about
  end
end