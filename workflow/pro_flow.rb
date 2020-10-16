require_relative 'workflow'

class ProFlow < Workflow
  def flow
    {
      ca: [],
      kr: [:ca],
      ba: [:kr],
      ua: [:ca],
      qt: [:ua],
      da: [
        :ba,
        :ua
      ],
      rc: [:da],
      rp: [:rc]
    }
  end

  def ca_done?
    item.ca
  end

  def kr_done?
    item.kr
  end

  def ba_done?
    item.ba
  end

  def ua_done?
    item.ua
  end

  def qt_done?
    item.qt
  end

  def da_done?
    item.da
  end

  def rc_done?
    item.rc
  end

  def rp_done?
    item.rp
  end
end
