#!/bin/bash

set -eu -o pipefail
exe=(cargo run --example stupicat --)

root="$(cd "${0%/*}" && pwd)"
# shellcheck source=./tests/utilities.sh
source "$root/utilities.sh"

SUCCESSFULLY=0

fixture="$root/fixtures"
snapshot="$fixture/snapshots"

title "stupicat"

(with "a mathematical expression"
  it "succeeds" && \
    WITH_SNAPSHOT="$snapshot/stupicat-math-output" \
    expect_run_sh $SUCCESSFULLY "${exe[*]} $fixture/math.md 2>/dev/null"
)

(with "a table"
  it "succeeds" && \
    WITH_SNAPSHOT="$snapshot/stupicat-table-output" \
    expect_run_sh $SUCCESSFULLY "${exe[*]} $fixture/table.md 2>/dev/null"
)

(with "a more complex ordered list"
  it "succeeds" && \
    WITH_SNAPSHOT="$snapshot/stupicat-ordered-output" \
    expect_run_sh $SUCCESSFULLY "${exe[*]} $fixture/ordered.md 2>/dev/null"
)

(with "a more complex unordered list"
  it "succeeds" && \
    WITH_SNAPSHOT="$snapshot/stupicat-unordered-output" \
    expect_run_sh $SUCCESSFULLY "${exe[*]} $fixture/unordered.md 2>/dev/null"
)

(with "a standard common-mark example file"
  (when "processing all events in one invocation"
    it "succeeds" && \
      WITH_SNAPSHOT="$snapshot/stupicat-output" \
      expect_run_sh $SUCCESSFULLY "${exe[*]} $fixture/common-mark.md 2>/dev/null"
  )
  (when "processing event by event"
    it "succeeds" && \
      STUPICAT_STATE_TEST=1 \
      WITH_SNAPSHOT="$snapshot/stupicat-event-by-event-output" \
      expect_run_sh $SUCCESSFULLY "${exe[*]} $fixture/common-mark.md 2>/dev/null"
  )
)

(with "markdown and html nested"
  it "succeeds" && \
    WITH_SNAPSHOT="$snapshot/stupicat-nested-output" \
    expect_run_sh $SUCCESSFULLY "${exe[*]} $fixture/nested.md 2>/dev/null"
)

(with "lists and nested content"
  it "succeeds" && \
    WITH_SNAPSHOT="$snapshot/stupicat-lists-nested-output" \
    expect_run_sh $SUCCESSFULLY "${exe[*]} $fixture/lists-nested.md 2>/dev/null"
)

(with "table with html"
  it "succeeds" && \
    WITH_SNAPSHOT="$snapshot/stupicat-table-with-html-output" \
    expect_run_sh $SUCCESSFULLY "${exe[*]} $fixture/table-with-html.md 2>/dev/null"
)

(with "heading with identifier and classes"
  it "succeeds" && \
    WITH_SNAPSHOT="$snapshot/stupicat-heading-id-classes-output" \
    expect_run_sh $SUCCESSFULLY "${exe[*]} $fixture/heading-id-classes.md 2>/dev/null"
)

(with "repeated shortcut links"
  it "succeeds" && \
    WITH_SNAPSHOT="$snapshot/stupicat-repeated-shortcut-links-output" \
    expect_run_sh $SUCCESSFULLY "${exe[*]} $fixture/repeated-shortcut-links.md 2>/dev/null"
)

(with "indented code block"
  it "succeeds" && \
    WITH_SNAPSHOT="$snapshot/stupicat-indented-code-block" \
    expect_run_sh $SUCCESSFULLY "${exe[*]} $fixture/indented-code-block.md 2>/dev/null"
)

(with "yaml frontmatter"
  it "succeeds" && \
    WITH_SNAPSHOT="$snapshot/stupicat-yaml-frontmatter-output" \
    expect_run_sh $SUCCESSFULLY "${exe[*]} $fixture/yaml-frontmatter.md 2>/dev/null"
)

(with "toml frontmatter"
  it "succeeds" && \
    WITH_SNAPSHOT="$snapshot/stupicat-toml-frontmatter-output" \
    expect_run_sh $SUCCESSFULLY "${exe[*]} $fixture/toml-frontmatter.md 2>/dev/null"
)

(with "table with escaped characters in cells"
  it "succeeds in reproducing the escapes" && \
    WITH_SNAPSHOT="$snapshot/stupicat-table-with-escapes-output" \
    expect_run_sh $SUCCESSFULLY "${exe[*]} $fixture/table-with-escapes.md 2>/dev/null"
)

(with "definition lists"
  it "succeeds in reproducing definition-list indentation" && \
    WITH_SNAPSHOT="$snapshot/stupicat-definition-list-output" \
    expect_run_sh $SUCCESSFULLY "${exe[*]} $fixture/definition-list.md 2>/dev/null"
)

(with "super and subscript"
  it "succeeds" && \
    WITH_SNAPSHOT="$snapshot/stupicat-super-sub-script-output" \
    expect_run_sh $SUCCESSFULLY "${exe[*]} $fixture/super-sub-script.md 2>/dev/null"
)
