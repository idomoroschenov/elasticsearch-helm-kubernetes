{{/*
Elasticsearch Labels
*/}}
{{- define "elasticsearch.labels" -}}
app.kubernetes.io/application-owner: run
app.kubernetes.io/name: {{ include "elasticsearch.fullname" . }}
helm.sh/chart: "{{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}"
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: elasticsearch
{{- end -}}

{{- define "elasticsearch.fullname" -}}
{{- if .Values.elasticsearchNameOverwrite -}}
{{- .Values.elasticsearchNameOverwrite -}}
{{- else if .Values.global -}}
{{- if .Values.global.elasticsearchApplicationName -}}
{{- .Values.global.elasticsearchApplicationName -}}
{{- end -}}
{{- else -}}
{{- print "elasticsearch-default" -}}
{{- end -}}
{{- end -}}
