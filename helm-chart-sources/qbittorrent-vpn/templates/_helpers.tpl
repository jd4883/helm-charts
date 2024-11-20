{{/*
Expand the name of the chart.
*/}}
{{- define "qbittorrent-vpn.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/* qbittorrent-vpn Annotations */}}
{{- define "qbittorrent-vpn.annotations" -}}
meta.helm.sh/release-name: {{ .Release.Name | quote }}
meta.helm.sh/release-namespace: {{ .Release.Namespace | quote }}
{{- if .Values.annotations }}
{{- toYaml .Values.annotations | trim }}
{{- end }}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "qbittorrent-vpn.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "qbittorrent-vpn.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "qbittorrent-vpn.labels" -}}
helm.sh/chart: {{ include "qbittorrent-vpn.chart" . }}
{{ include "qbittorrent-vpn.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Values.labels }}
{{- toYaml .Values.labels | trim }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "qbittorrent-vpn.selectorLabels" -}}
app.kubernetes.io/name: {{ include "qbittorrent-vpn.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "qbittorrent-vpn.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "qbittorrent-vpn.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
