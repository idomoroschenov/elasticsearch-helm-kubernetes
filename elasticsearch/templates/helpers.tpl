{{/*
Common Labels
*/}}

{{- define "common.labels" -}}
releaseName: {{ .Release.Name | quote }}
applicationOwner: Run
{{- end -}}
