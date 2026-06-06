"""
LLMGate unit tests — wrapper for config/script validation.
"""
import subprocess
import os
import unittest

PROJ_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))


class TestLLMGateScripts(unittest.TestCase):
    """Test that all LLMGate scripts exist and are well-formed."""

    def test_deploy_sh_exists(self):
        self.assertTrue(os.path.exists(os.path.join(PROJ_ROOT, "scripts/deploy.sh")))

    def test_verify_deployment_exists(self):
        self.assertTrue(os.path.exists(os.path.join(PROJ_ROOT, "scripts/verify-deployment.sh")))

    def test_deploy_has_shebang(self):
        with open(os.path.join(PROJ_ROOT, "scripts/deploy.sh")) as f:
            self.assertTrue(f.readline().startswith("#!/bin/bash"))

    def test_deploy_has_set_flags(self):
        with open(os.path.join(PROJ_ROOT, "scripts/deploy.sh")) as f:
            content = f.read()
            self.assertIn("set -euo pipefail", content)

    def test_deploy_uses_docker_compose(self):
        with open(os.path.join(PROJ_ROOT, "scripts/deploy.sh")) as f:
            content = f.read()
            self.assertIn("docker compose", content)

    def test_verify_checks_providers(self):
        with open(os.path.join(PROJ_ROOT, "scripts/verify-deployment.sh")) as f:
            content = f.read()
            self.assertIn("providers/qwen.yaml", content)


class TestLLMGateConfigs(unittest.TestCase):
    """Test that LLMGate YAML configs are valid."""

    def _import_yaml(self):
        try:
            import yaml
            return yaml
        except ImportError:
            self.skipTest("PyYAML not installed")

    def test_docker_compose_valid(self):
        yaml = self._import_yaml()
        path = os.path.join(PROJ_ROOT, "docker-compose.yml")
        self.assertTrue(os.path.exists(path))
        with open(path) as f:
            data = yaml.safe_load(f)
        self.assertIn("helicone-gateway", data.get("services", {}))
        self.assertIn("postgres", data.get("services", {}))
        self.assertIn("redis", data.get("services", {}))
        self.assertIn("clickhouse", data.get("services", {}))

    def test_qwen_provider_valid(self):
        yaml = self._import_yaml()
        path = os.path.join(PROJ_ROOT, "providers/qwen.yaml")
        self.assertTrue(os.path.exists(path))
        with open(path) as f:
            data = yaml.safe_load(f)
        self.assertIsNotNone(data)

    def test_deepseek_provider_valid(self):
        yaml = self._import_yaml()
        path = os.path.join(PROJ_ROOT, "providers/deepseek.yaml")
        self.assertTrue(os.path.exists(path))
        with open(path) as f:
            data = yaml.safe_load(f)
        self.assertIsNotNone(data)

    def test_routing_strategy_valid(self):
        yaml = self._import_yaml()
        path = os.path.join(PROJ_ROOT, "strategies/routing.yaml")
        self.assertTrue(os.path.exists(path))
        with open(path) as f:
            data = yaml.safe_load(f)
        self.assertIsNotNone(data)

    def test_github_actions_valid(self):
        yaml = self._import_yaml()
        path = os.path.join(PROJ_ROOT, "ci/github-actions.yml")
        self.assertTrue(os.path.exists(path))
        with open(path) as f:
            data = yaml.safe_load(f)
        self.assertIsNotNone(data)

    def test_gitlab_ci_valid(self):
        yaml = self._import_yaml()
        path = os.path.join(PROJ_ROOT, "ci/gitlab-ci.yml")
        self.assertTrue(os.path.exists(path))
        with open(path) as f:
            data = yaml.safe_load(f)
        self.assertIsNotNone(data)

    def test_env_example_exists(self):
        self.assertTrue(os.path.exists(os.path.join(PROJ_ROOT, ".env.example")))


if __name__ == "__main__":
    unittest.main()
