# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141031234747) do

  create_table "build_artifacts", force: true do |t|
    t.integer  "build_attempt_id"
    t.string   "log_file"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "build_artifacts", ["build_attempt_id"], name: "index_build_artifacts_on_build_attempt_id", using: :btree

  create_table "build_attempts", force: true do |t|
    t.integer  "build_part_id"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.string   "builder"
    t.string   "state"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "build_attempts", ["build_part_id"], name: "index_build_attempts_on_build_part_id", using: :btree

  create_table "build_parts", force: true do |t|
    t.integer  "build_id"
    t.string   "kind"
    t.text     "paths"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.text     "options"
    t.string   "queue"
    t.integer  "retry_count", default: 0
  end

  add_index "build_parts", ["build_id"], name: "index_build_parts_on_build_id", using: :btree
  add_index "build_parts", ["paths"], name: "index_build_parts_on_paths", length: {"paths"=>255}, using: :btree

  create_table "builds", force: true do |t|
    t.string   "ref",                        limit: 40,                 null: false
    t.string   "state"
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.integer  "project_id"
    t.boolean  "merge_on_success"
    t.string   "branch"
    t.boolean  "build_failure_email_sent",              default: false, null: false
    t.boolean  "promoted"
    t.string   "on_success_script_log_file"
    t.text     "error_details"
    t.boolean  "build_success_email_sent",              default: false, null: false
  end

  add_index "builds", ["project_id"], name: "index_builds_on_project_id", using: :btree
  add_index "builds", ["ref", "project_id"], name: "index_builds_on_ref_and_project_id", unique: true, using: :btree

  create_table "projects", force: true do |t|
    t.string   "name"
    t.string   "branch"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "repository_id"
  end

  add_index "projects", ["name", "branch"], name: "index_projects_on_name_and_branch", using: :btree
  add_index "projects", ["repository_id"], name: "index_projects_on_repository_id", using: :btree

  create_table "repositories", force: true do |t|
    t.string   "url"
    t.string   "test_command"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "github_post_receive_hook_id"
    t.boolean  "run_ci"
    t.boolean  "build_pull_requests"
    t.string   "on_green_update"
    t.string   "repo_cache_dir"
    t.boolean  "send_build_failure_email",    default: true,  null: false
    t.string   "on_success_script"
    t.integer  "timeout",                     default: 40
    t.string   "name",                                        null: false
    t.boolean  "allows_kochiku_merges",       default: true
    t.string   "host",                                        null: false
    t.string   "namespace"
    t.boolean  "send_build_success_email",    default: true,  null: false
    t.boolean  "email_on_first_failure",      default: false, null: false
  end

  add_index "repositories", ["host", "namespace", "name"], name: "index_repositories_on_host_and_namespace_and_name", unique: true, using: :btree
  add_index "repositories", ["url"], name: "index_repositories_on_url", using: :btree

end
