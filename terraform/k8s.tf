provider "kubernetes" {
  host = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token = data.aws_eks_cluster_auth.eks.token
}

resource "kubernetes_deployment" "search" {
  metadata {
    name = "search-api"
    labels = {
      App = "Search"
    }
  }

  spec {
    selector {
      match_labels = {
        App = "Search"
      }
    }
    template {
      metadata {
        labels = {
          App = "Search"
        }
      }
      spec {
        container {
          image = "nginx:1.7.8"
          name  = "search-api"

          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "graph" {
  metadata {
    name = "graph-api"
    labels = {
      App = "Graph"
    }
  }

  spec {
    selector {
      match_labels = {
        App = "Graph"
      }
    }
    template {
      metadata {
        labels = {
          App = "Graph"
        }
      }
      spec {
        container {
          image = "nginx:1.7.8"
          name  = "graph-api"

          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}
