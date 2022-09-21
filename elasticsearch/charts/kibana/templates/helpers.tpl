{{/*
Kibana Labels
*/}}
{{ define "kibana.labels" }}
app.kubernetes.io/application-owner: run
app.kubernetes.io/name: kibana-default
helm.sh/chart: "{{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}"
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: kibana
{{ end }}

{{/*
Kibana Config
*/}}
{{ define "kibana.config" }}
server.port: {{ .Values.containerPort }}
server.host: "0.0.0.0/0"
server.name: {{ .Values.kibanaApplicatioName }}
elasticsearch.hosts: ["http://{{ .Values.global.elasticsearchApplicationName }}:9200"]
{{ end }}
