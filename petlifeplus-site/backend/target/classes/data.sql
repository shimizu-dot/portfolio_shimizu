INSERT INTO roles (id, role_code, role_name) VALUES
(1, 'ADMIN', '管理者'),
(2, 'USER', '一般ユーザー'),
(3, 'VET', '獣医師'),
(4, 'STAFF', 'スタッフ');

INSERT INTO users (id, role_id, name, email, password_hash, phone, status) VALUES
(1, 1, '管理 太郎', 'admin@petlifeplus.local', '$2a$10$abcdefghijklmnopqrstuvABCDEFGHIJKLMN1234567890abcd', '090-1111-1111', 'ACTIVE'),
(2, 2, '飼主 花子', 'owner1@petlifeplus.local', '$2a$10$abcdefghijklmnopqrstuvABCDEFGHIJKLMN1234567890abce', '090-2222-2222', 'ACTIVE'),
(3, 2, '飼主 次郎', 'owner2@petlifeplus.local', '$2a$10$abcdefghijklmnopqrstuvABCDEFGHIJKLMN1234567890abcf', '090-3333-3333', 'ACTIVE'),
(4, 3, '獣医 三郎', 'vet1@petlifeplus.local', '$2a$10$abcdefghijklmnopqrstuvABCDEFGHIJKLMN1234567890abcg', '090-4444-4444', 'ACTIVE'),
(5, 4, '受付 四郎', 'staff1@petlifeplus.local', '$2a$10$abcdefghijklmnopqrstuvABCDEFGHIJKLMN1234567890abch', '090-5555-5555', 'ACTIVE');

INSERT INTO pets (id, owner_user_id, name, species, breed, sex, birth_date, weight_baseline_kg) VALUES
(1, 2, 'ポチ', 'DOG', '柴犬', 'MALE', '2021-03-01', 8.50),
(2, 2, 'ミケ', 'CAT', '雑種', 'FEMALE', '2022-07-12', 3.80),
(3, 3, 'レオ', 'DOG', 'トイプードル', 'MALE', '2020-11-23', 5.20);

INSERT INTO health_records (id, pet_id, recorded_by_user_id, record_date, weight_kg, meal_memo, exercise_minutes, note) VALUES
(1, 1, 2, '2026-05-10', 8.60, '食欲良好', 30, '特記事項なし'),
(2, 2, 2, '2026-05-10', 3.75, '少し食欲低下', 15, '様子見'),
(3, 3, 3, '2026-05-11', 5.25, '通常', 25, '元気');

INSERT INTO symptom_checks (id, pet_id, requested_by_user_id, symptom_type, onset_text, memo, severity, recommendation, ai_model) VALUES
(1, 2, 2, 'VOMITING', '今朝から', '1回嘔吐', 'MEDIUM', 'CONSULT', 'gpt-4.1-mini'),
(2, 1, 2, 'COUGH', '昨日から', '夜に咳', 'LOW', 'OBSERVE', 'gpt-4.1-mini');

INSERT INTO appointments (id, pet_id, owner_user_id, staff_user_id, appointment_type, channel, scheduled_at, status, note) VALUES
(1, 2, 2, 4, 'CONSULTATION', 'VISIT', '2026-05-20 10:00:00', 'CONFIRMED', '嘔吐の相談'),
(2, 1, 2, 4, 'MEDICAL', 'HOSPITAL', '2026-05-22 14:30:00', 'REQUESTED', '定期健診');

INSERT INTO medical_histories (id, pet_id, appointment_id, handled_by_user_id, performed_on, treatment_detail, diagnosis, prescription) VALUES
(1, 2, 1, 4, '2026-05-20', '触診・体温測定', '軽度胃腸炎', '整腸剤3日分');

INSERT INTO medical_attachments (id, medical_history_id, file_name, file_path, file_mime_type, file_size_bytes, description) VALUES
(1, 1, 'result_20260520.pdf', '/uploads/medical/result_20260520.pdf', 'application/pdf', 245760, '診療結果PDF');

INSERT INTO plans (id, name, monthly_fee, features_json, is_active) VALUES
(1, 'Basic', 980.00, '{"aiCheck": true, "notifications": true}'::jsonb, true),
(2, 'Premium', 1980.00, '{"aiCheck": true, "notifications": true, "prioritySupport": true}'::jsonb, true);

INSERT INTO subscriptions (id, user_id, pet_id, plan_id, start_date, end_date, status, auto_renew) VALUES
(1, 2, 1, 1, '2026-05-01', NULL, 'ACTIVE', true),
(2, 2, 2, 2, '2026-05-01', NULL, 'ACTIVE', true);

INSERT INTO invoices (id, subscription_id, invoice_number, invoice_date, due_date, amount, payment_status, issued_at, paid_at) VALUES
(1, 1, 'INV-202605-0001', '2026-05-01', '2026-05-31', 980.00, 'PAID', '2026-05-01 09:00:00', '2026-05-02 10:00:00'),
(2, 2, 'INV-202605-0002', '2026-05-01', '2026-05-31', 1980.00, 'UNPAID', '2026-05-01 09:05:00', NULL);

INSERT INTO payments (id, invoice_id, paid_amount, paid_at, payment_method, transaction_ref, status) VALUES
(1, 1, 980.00, '2026-05-02 10:00:00', 'CARD', 'TXN-PLP-0001', 'SUCCEEDED');

INSERT INTO notifications (id, notification_type, title, body, scheduled_at, sent_at, delivery_status, created_by_user_id) VALUES
(1, 'REMINDER', '明日の予約通知', '明日10:00に相談予約があります。', '2026-05-19 18:00:00', NULL, 'SCHEDULED', 5),
(2, 'INFO', '新機能のお知らせ', 'AI症状チェック機能を更新しました。', NULL, '2026-05-10 12:00:00', 'SENT', 1);

INSERT INTO notification_recipients (notification_id, user_id, read_at, delivery_status) VALUES
(1, 2, NULL, 'PENDING'),
(2, 2, '2026-05-10 12:10:00', 'SENT'),
(2, 3, NULL, 'SENT');

INSERT INTO email_templates (id, template_code, subject_template, body_template, is_active) VALUES
(1, 'APPOINTMENT_REMINDER', '【Pet Life Plus】予約リマインド', 'ご予約の前日通知です。', true),
(2, 'INVOICE_NOTICE', '【Pet Life Plus】請求のお知らせ', '今月分の請求をご確認ください。', true);

INSERT INTO email_messages (id, template_id, recipient_user_id, pet_id, appointment_id, invoice_id, subject, body, send_timing_at, status, error_message, sent_at) VALUES
(1, 1, 2, 2, 1, NULL, '【Pet Life Plus】予約リマインド', '明日10:00の予約があります。', '2026-05-19 18:00:00', 'QUEUED', NULL, NULL),
(2, 2, 2, NULL, NULL, 2, '【Pet Life Plus】請求のお知らせ', '請求番号INV-202605-0002のご案内です。', NULL, 'SENT', NULL, '2026-05-03 09:00:00');

SELECT setval(pg_get_serial_sequence('roles', 'id'), COALESCE((SELECT MAX(id) FROM roles), 1), true);
SELECT setval(pg_get_serial_sequence('users', 'id'), COALESCE((SELECT MAX(id) FROM users), 1), true);
SELECT setval(pg_get_serial_sequence('pets', 'id'), COALESCE((SELECT MAX(id) FROM pets), 1), true);
SELECT setval(pg_get_serial_sequence('health_records', 'id'), COALESCE((SELECT MAX(id) FROM health_records), 1), true);
SELECT setval(pg_get_serial_sequence('symptom_checks', 'id'), COALESCE((SELECT MAX(id) FROM symptom_checks), 1), true);
SELECT setval(pg_get_serial_sequence('appointments', 'id'), COALESCE((SELECT MAX(id) FROM appointments), 1), true);
SELECT setval(pg_get_serial_sequence('medical_histories', 'id'), COALESCE((SELECT MAX(id) FROM medical_histories), 1), true);
SELECT setval(pg_get_serial_sequence('medical_attachments', 'id'), COALESCE((SELECT MAX(id) FROM medical_attachments), 1), true);
SELECT setval(pg_get_serial_sequence('plans', 'id'), COALESCE((SELECT MAX(id) FROM plans), 1), true);
SELECT setval(pg_get_serial_sequence('subscriptions', 'id'), COALESCE((SELECT MAX(id) FROM subscriptions), 1), true);
SELECT setval(pg_get_serial_sequence('invoices', 'id'), COALESCE((SELECT MAX(id) FROM invoices), 1), true);
SELECT setval(pg_get_serial_sequence('payments', 'id'), COALESCE((SELECT MAX(id) FROM payments), 1), true);
SELECT setval(pg_get_serial_sequence('notifications', 'id'), COALESCE((SELECT MAX(id) FROM notifications), 1), true);
SELECT setval(pg_get_serial_sequence('email_templates', 'id'), COALESCE((SELECT MAX(id) FROM email_templates), 1), true);
SELECT setval(pg_get_serial_sequence('email_messages', 'id'), COALESCE((SELECT MAX(id) FROM email_messages), 1), true);
