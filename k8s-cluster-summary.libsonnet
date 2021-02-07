local grafana = import 'vendor/grafonnet-lib/grafonnet/grafana.libsonnet';
local graphPanel = grafana.graphPanel;
local prometheus = grafana.prometheus;

local dashboard = {
    /**
     * create dashboard
     *
     * @name dashboard.new
     *
     * @param title The title of the dashboard
     * @param tags (optional) Array of tags associated to the dashboard, e.g.`['tag1','tag2']`
     * @param description The description of the dashboard
    */
    new(title, tags, description):: grafana.dashboard.new(
        title,
        tags=tags,
        schemaVersion=18,
        editable=true,
        time_from='now-1h',
        refresh='1m',
        description=description,
    )
};

local podCountsPanel = {
    /**
     * create pod counts graph panel
     *
     * @name podCountsPanel.new
     *
     * @param title The title of the podCountsPanel
     * @param description The description of the panel
     * @param datasource Datasource
    */
    new(title, description, datasource):: graphPanel.new(
        title,
        decimals = 0,
        min = 0,
        datasource = datasource,
    )
    .addTarget(
        prometheus.target(
            'sum(kube_pod_status_ready{namespace="default"}))'
        )
    )
};

{
    dashboard: dashboard,
    podCountsPanel: podCountsPanel,
}