local tmpl = import "k8s-cluster-summary.libsonnet";
local dashboard = tmpl.dashboard;
local podCountsPanel = tmpl.podCountsPanel;

dashboard.new("booinfo-dev", ['kubernetes', 'dev'], 'summary of bookinfo k8s cluster')
  .addPanels(
    [
      podCountsPanel.new('pod count', 'クラスタpodの総数', 'prometheus') + {
        gridPos: { h: 8, w: 7, x: 0, y: 4 }
      },
    ]
  )